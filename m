From: Avi Kivity <avi@qumranet.com>
Subject: Re: [PATCH 0/5] paravirt clock source patches, #4
Date: Mon, 16 Jun 2008 06:53:29 -0700
Message-ID: <48567059.10102@qumranet.com>
References: <1212498439-1283-1-git-send-email-kraxel@redhat.com> <48454A38.4090907@goop.org> <48454BE5.1010007@redhat.com> <4846A033.7030007@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <4846A033.7030007@qumranet.com>
Sender: kvm-owner@vger.kernel.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, kvm@vger.kernel.org, virtualization@lists.osdl.org, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

Avi Kivity wrote:     
>>> This all looks pretty good.  How do you want this to get into the 
>>> kernel?
>>>     
>>
>> [ note: fixed up kvm list address: s/-owner// ]
>>
>> Good question.  The kvm patches have dependencies on not-yet merged
>> bits, so they have to go through the kvm queue.  The first two can also
>> go through Ingos x86 tree I guess.
>>
>>   
>
> Alternativey, if Ingo acks, I'll send all five through kvm.git.
>
> Note the kvm specific patches need to be backported as we want them 
> for 2.6.26.  I can do that.
>
> (Ingo: said patches are in 
> http://thread.gmane.org/gmane.comp.emulators.kvm.devel/18149)
>

What's happening with this?  Is it going through x86.git or what?

-- 
I have a truly marvellous patch that fixes the bug which this
signature is too narrow to contain.

