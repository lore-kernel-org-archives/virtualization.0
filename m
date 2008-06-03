From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 0/5] paravirt clock source patches, #4
Date: Tue, 03 Jun 2008 15:49:25 +0200
Message-ID: <48454BE5.1010007@redhat.com>
References: <1212498439-1283-1-git-send-email-kraxel@redhat.com> <48454A38.4090907@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <48454A38.4090907@goop.org>
Sender: kvm-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: kvm@vger.kernel.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> Gerd Hoffmann wrote:
>> paravirt clock source patches, next round.
>>
>> There is now a pvclock-abi.h file with the structs and some longish
>> comments in it and everybody is switched over to use the stuff in
>> there.
> 
> This all looks pretty good.  How do you want this to get into the kernel?

[ note: fixed up kvm list address: s/-owner// ]

Good question.  The kvm patches have dependencies on not-yet merged
bits, so they have to go through the kvm queue.  The first two can also
go through Ingos x86 tree I guess.

cheers,
  Gerd

-- 
http://kraxel.fedorapeople.org/xenner/
