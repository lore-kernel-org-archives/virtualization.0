From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 12/22] virtio_pci: allow duplicate capabilities.
Date: Thu, 21 Mar 2013 08:26:52 -0700
Message-ID: <514B26BC.6010700@zytor.com>
References: <1363854584-25795-1-git-send-email-rusty@rustcorp.com.au>
	<1363854584-25795-13-git-send-email-rusty@rustcorp.com.au>
	<20130321102814.GC30493@redhat.com>
	<514B188A.3030502@zytor.com> <20130321144330.GA1454@redhat.com>
	<514B1D25.9090206@zytor.com> <20130321151937.GB1454@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130321151937.GB1454@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 03/21/2013 08:19 AM, Michael S. Tsirkin wrote:
>>
>> In BIOS (e.g. SeaBIOS), using MMIO is very difficult, so your boot ROM
>> probably wants to use I/O space even if MMIO is available.
> 
> Is this a real concern?  Modern cards seem to supply PXE ROMs even
> though they have no IO BARs.
> 

Most of them do really ugly hacks in hardware (like putting in a "back
door" in config space) to make that possible.

> 
> Problem is, BIOS and OS normally assume failure to allocate
> any resources means card won't function and disable it.
> So it does not seem to be worth it to have such a
> device specific failover ability.
> 

That is a violation of the PCIe spec; the PCIe spec specifically states
that failure to allocate an I/O BAR should still allow the device to
function.  So we shouldn't rule it out going forward.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
