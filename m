From: Avi Kivity <avi@qumranet.com>
Subject: Re: [PATCH 0/5] paravirt clock source patches, #5
Date: Mon, 23 Jun 2008 11:08:49 +0300
Message-ID: <485F5A11.1000303@qumranet.com>
References: <1212502653-4521-1-git-send-email-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1212502653-4521-1-git-send-email-kraxel@redhat.com>
Sender: kvm-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, kvm@vger.kernel.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

Gerd Hoffmann wrote:
> paravirt clock source patches, next round.
>
> There is now a pvclock-abi.h file with the structs and some longish
> comments in it and everybody is switched over to use the stuff in
> there.
>
> Some minor tweaks after super-fast review by Jeremy.
>
> The queue is on top of the kvm git tree.  The first two patches should
> have no kvm dependencies and should apply to linus tree just fine.
>
>   

Jeremy, can you ack the Xen bits for 2.6.26?


-- 
error compiling committee.c: too many arguments to function

