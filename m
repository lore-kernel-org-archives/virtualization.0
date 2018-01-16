From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: PCIe ordering and new VIRTIO packed ring format.
Date: Tue, 16 Jan 2018 04:40:30 +0200
Message-ID: <20180116042342-mutt-send-email-mst__25522.3415595994$1516070338$gmane$org@kernel.org>
References: <AM4PR0501MB27230E63B2FC6BBF79D1419FD4150@AM4PR0501MB2723.eurprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <AM4PR0501MB27230E63B2FC6BBF79D1419FD4150@AM4PR0501MB2723.eurprd05.prod.outlook.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ilya Lesokhin <ilyal@mellanox.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Or Gerlitz <ogerlitz@mellanox.com>, Liran Liss <liranl@mellanox.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Jan 14, 2018 at 07:45:50AM +0000, Ilya Lesokhin wrote:
> Hi,
> I have a concern about the portability of offloading the new VIRTIO packed ring format to hardware.
> 
> According to the PCIe rev 2.0, paragraph 2.4.2. Update Ordering and Granularity Observed by a Read Transaction"
> " if a host CPU writes a QWORD to host memory, a Requester reading that QWORD from host memory may observe a portion of the QWORD updated and another portion of it containing the old value."
> 
> This means that after the device reads a 16byte descriptor, it cannot know that all the values In the descriptor are up to date even if the VIRTQ_DESC_F_AVAIL bit is set.
> This is true even if the driver uses the appropriate memory barriers.
> 
> We encountered this behavior in practice on x86 servers. Our solution was to add an index to the latest valid descriptor
> 
> Note that in practice the update granularity in x86 seems to be a cacheline, But this is not guaranteed by the spec. 
> The spec only makes the following recommendation:
> "While not required by this specification, it is strongly recommended that host platforms guarantee that when a host CPU writes aligned DWORDs or aligned QWORDs to host memory, the update granularity observed by a PCI Express read will not be smaller than a DWORD."
> 
> Thanks,
> Ilya

This is a very good point.  This consideration is one of the reasons I
included last valid descriptor in the driver notification.  My guess
would be that such hardware should never use driver event suppression.
As a result, driver will always send notifications after each batch of
descriptors. Device can use that to figure out which descriptors to
fetch. Luckily, with pass-through device memory can be mapped
directly into the VM, so no the notification will not trigger
a VM exit.

It would be interesting to find out whether specific host systems
give a stronger guarantee than what is required by the PCIE spec.
If so we could add e.g. a feature bit to let the device
know it's safe to read beyond the index supplied in the kick
notification. Drivers would detect this and use it to reduce
the overhead.

Conversely, this is also why I selected:
#define VIRTQ_DESC_F_USED      15
this way we don't have the same issue in the reverse order:
the last byte is used to mark buffer as used,
which actually seems to be guaranteed to happen the last from
software point of view in a portable.

-- 
MST
