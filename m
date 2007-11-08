From: Anthony Liguori <aliguori@us.ibm.com>
Subject: Re: [PATCH][VIRTIO] Fix vring_init() ring computations
Date: Wed, 07 Nov 2007 19:06:07 -0600
Message-ID: <473260FF.1030101@us.ibm.com>
References: <11944039492411-git-send-email-aliguori@us.ibm.com> <200711071657.40992.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759798AbXKHBGT@vger.kernel.org>
In-Reply-To: <200711071657.40992.rusty@rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Rusty Russell <rusty@rusycorp.com.au>, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> On Wednesday 07 November 2007 13:52:29 Anthony Liguori wrote:
>   
>> This patch fixes a typo in vring_init(). 
>>     
>
> Thanks, applied.
>
> I've put it in the new, experimental virtio git tree on git.kernel.org.
>   

Hrm, perhaps you forgot to push?  I don't see it in the tree although I 
see the config ops refactoring.

Regards,

Anthony Liguori

> Cheers,
> Rusty.
>   
