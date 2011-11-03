From: Avi Kivity <avi@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] virtio: Add PCI memory BAR in addition to
	PIO BAR
Date: Thu, 03 Nov 2011 16:53:44 +0200
Message-ID: <4EB2AAF8.1000209@redhat.com>
References: <1317360376-12090-1-git-send-email-david@gibson.dropbear.id.au>	<4EB07096.4070806@us.ibm.com>
	<4EB26EA5.4060606@redhat.com>	<4EB291F4.8070503@us.ibm.com>
	<4EB29381.9060707@redhat.com>	<4EB2993C.9000902@codemonkey.ws>
	<4EB29B00.10907@redhat.com>	<4EB29BEB.4070603@codemonkey.ws>
	<20111103143129.GA20860@redhat.com>
	<4EB2A747.9040909@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4EB2A747.9040909@codemonkey.ws>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Pekka Enberg <penberg@kernel.org>, David Gibson <david@gibson.dropbear.id.au>
List-Id: virtualization@lists.linuxfoundation.org

On 11/03/2011 04:37 PM, Anthony Liguori wrote:
>
>>>>>> 2. Proposed spec patch, kernel change, qemu change
>>>>>> 3. Buy-ins from spec maintainer, kernel driver maintainer, qemu
>>>>>> device
>>>>>> maintainer (only regarding the ABI, not the code)
>>>>>
>>>>> I don't think this is how it's working today.  I would be happy
>>>>> with a
>>>>> flow like this.
>>>>
>>>> If Michael and Rusty agree, we can adopt it immediately.
>>>>
>>
>> If I understand the proposal, what is suggested is that
>> all of spec, kvm and virtio patches are posted on list and
>> acked before merging any one of them?
>>
>> Sure, this makes sense.
>
> Well, what's needed before the spec is changed is an interesting
> question, but I think the main thing is, don't commit any virtio ABI
> changes to vhost, QEMU, NKT, or the kernel until the spec for the
> change has been committed.
>
> It would be nice to have a working implementation before committing a
> spec change.  Even nicer would be to have Acked-by's a maintainer in
> each area affected.
>

Those are steps 2 and 3 of the proposed process.

-- 
error compiling committee.c: too many arguments to function
