From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 1/4] Add helper functions for paravirtual clocksources.
Date: Tue, 27 May 2008 15:52:40 +0200
Message-ID: <483C1228.4010004@redhat.com>
References: <1210924885-5353-1-git-send-email-kraxel@redhat.com>
	<1210924885-5353-2-git-send-email-kraxel@redhat.com>
	<4834A630.7060208@goop.org> <48353DB4.1020303@redhat.com>
	<483C0A65.2090208@redhat.com> <483C0B4E.9050909@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <483C0B4E.9050909@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: kvm-devel@lists.sourceforge.net, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> Hm?  I sent a reply, didn't I?  Attached again.

Hmm, seems to have gotten lost somewhere, I can't remember having seen
that one.  Lossy email sucks :-(

>> Hmm, what is the state of include/xen/interface/?  It is a straight copy
>> of the xen public header files, right?  Is it really ok to modify them?
>>   
> 
> Yeah, sure.  They were copied once, but they can now drift without 
> consequence.  Xen defines an ABI, so it doesn't matter how the source 
> spells the names of the structures.

Ok, so I'll go just doing that ;)

>>> This comment is confusing.  Are you explaining why the tsc is read
>>> within the loop?  I think it can be clarified.
>>>     
>> This was just copyed over from somewhere else (kvmclock I think).
>>   
> 
> OK, but it still needs to be clarified.

Yep, will do.

> Also, the patches themselves need some changelogs.  Even though they're 
> mostly just code motion, it would be good if the changelog for the 
> common pvclock code had a description of the basics of operation.
> 
> Also, one implicit part of the ABI which should be explicitly documented 
> is that the interface expects that the host updates the per-vcpu time 
> structures on the same physical CPU that the guest runs, and that's why 
> we can avoid explicit cross-cpu ordering barriers.

pvclock.h is probably a good place for the structs and the comments ...

cheers,
  Gerd

-- 
http://kraxel.fedorapeople.org/xenner/
