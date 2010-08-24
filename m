From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 1/2] S390: take a full byte as ext_param indicator
Date: Tue, 24 Aug 2010 14:32:30 +0200
Message-ID: <4C73BBDE.9020701__19001.007898669$1282653274$gmane$org@suse.de>
References: <1282599077-29857-1-git-send-email-agraf@suse.de>
	<4C736EAF.9020107@de.ibm.com> <4C73B5C1.5040603@suse.de>
	<4C73B78C.2030003@de.ibm.com> <4C73B97E.2060303@redhat.com>
	<4C73BA22.4000902@suse.de> <4C73BB5C.1030008@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4C73BB5C.1030008@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@redhat.com>
Cc: KVM list <kvm@vger.kernel.org>, Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>, Carsten Otte <carsteno@de.ibm.com>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

Avi Kivity wrote:
>  On 08/24/2010 03:25 PM, Alexander Graf wrote:
>> Avi Kivity wrote:
>>>   On 08/24/2010 03:14 PM, Christian Borntraeger wrote:
>>>> I have no strong opinion on that, but I think its more a matter of
>>>> where
>>>> to put an interface description. A header file seems just the right
>>>> place.
>>>> I will let you (or Rusty) decide.
>>> First of all we need a virtio/s390 specification, like we have a
>>> virtio/pci spec.
>> Sure, go ahead and write one :). All the bits are open.
>> No seriously, I've wanted to write one for quite a while but this is not
>> the right patch set for this.
>
> Perhaps we should freeze virtio/s390 development until someone feels
> sufficiently motivated.

Sure, go ahead. I don't think that'll help anyone but if it makes you
feel good...


Alex
