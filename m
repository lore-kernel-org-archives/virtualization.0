From: Ilya Lesokhin <ilyal@mellanox.com>
Subject: PCIe ordering and new VIRTIO packed ring format.
Date: Sun, 14 Jan 2018 07:45:50 +0000
Message-ID: <AM4PR0501MB27230E63B2FC6BBF79D1419FD4150__21369.506562087$1515915863$gmane$org@AM4PR0501MB2723.eurprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Or Gerlitz <ogerlitz@mellanox.com>, Liran Liss <liranl@mellanox.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi,
I have a concern about the portability of offloading the new VIRTIO packed ring format to hardware.

According to the PCIe rev 2.0, paragraph 2.4.2. Update Ordering and Granularity Observed by a Read Transaction"
" if a host CPU writes a QWORD to host memory, a Requester reading that QWORD from host memory may observe a portion of the QWORD updated and another portion of it containing the old value."

This means that after the device reads a 16byte descriptor, it cannot know that all the values In the descriptor are up to date even if the VIRTQ_DESC_F_AVAIL bit is set.
This is true even if the driver uses the appropriate memory barriers.

We encountered this behavior in practice on x86 servers. Our solution was to add an index to the latest valid descriptor

Note that in practice the update granularity in x86 seems to be a cacheline, But this is not guaranteed by the spec. 
The spec only makes the following recommendation:
"While not required by this specification, it is strongly recommended that host platforms guarantee that when a host CPU writes aligned DWORDs or aligned QWORDs to host memory, the update granularity observed by a PCI Express read will not be smaller than a DWORD."

Thanks,
Ilya
