From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 12/22] virtio_pci: allow duplicate capabilities.
Date: Thu, 21 Mar 2013 07:45:57 -0700
Message-ID: <514B1D25.9090206@zytor.com>
References: <1363854584-25795-1-git-send-email-rusty@rustcorp.com.au>
	<1363854584-25795-13-git-send-email-rusty@rustcorp.com.au>
	<20130321102814.GC30493@redhat.com>
	<514B188A.3030502@zytor.com> <20130321144330.GA1454@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130321144330.GA1454@redhat.com>
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

On 03/21/2013 07:43 AM, Michael S. Tsirkin wrote:
>>
>> The reason to support this is that a guest written to only handle one or
>> the other doesn't prevent the hypervisor from offering the other to
>> guests.  We probably want to specify that if the guest doesn't care, it
>> should use the first one offered by the host.
>>
> 
> What are the configurations where having many ways is helpful?
> Any examples?
> 

In BIOS (e.g. SeaBIOS), using MMIO is very difficult, so your boot ROM
probably wants to use I/O space even if MMIO is available.

If you are preferring I/O space because it is faster (vmexit), then you
still want to allow MMIO if the resource is not available.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
