From: Avi Kivity <avi@qumranet.com>
Subject: Re: [PATCH 0/5] paravirt clock source patches, #4
Date: Wed, 04 Jun 2008 17:01:23 +0300
Message-ID: <4846A033.7030007@qumranet.com>
References: <1212498439-1283-1-git-send-email-kraxel@redhat.com> <48454A38.4090907@goop.org> <48454BE5.1010007@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <48454BE5.1010007@redhat.com>
Sender: kvm-owner@vger.kernel.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, kvm@vger.kernel.org, virtualization@lists.osdl.org, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

Gerd Hoffmann wrote:
> Jeremy Fitzhardinge wrote:
>   
>> Gerd Hoffmann wrote:
>>     
>>> paravirt clock source patches, next round.
>>>
>>> There is now a pvclock-abi.h file with the structs and some longish
>>> comments in it and everybody is switched over to use the stuff in
>>> there.
>>>       
>> This all looks pretty good.  How do you want this to get into the kernel?
>>     
>
> [ note: fixed up kvm list address: s/-owner// ]
>
> Good question.  The kvm patches have dependencies on not-yet merged
> bits, so they have to go through the kvm queue.  The first two can also
> go through Ingos x86 tree I guess.
>
>   

Alternativey, if Ingo acks, I'll send all five through kvm.git.

Note the kvm specific patches need to be backported as we want them for 
2.6.26.  I can do that.

(Ingo: said patches are in 
http://thread.gmane.org/gmane.comp.emulators.kvm.devel/18149)

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

