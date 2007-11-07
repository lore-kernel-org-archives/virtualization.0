From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH][VIRTIO] Fix vring_init() ring computations
Date: Wed, 7 Nov 2007 16:57:40 +1100
Message-ID: <200711071657.40992.rusty@rustcorp.com.au>
References: <11944039492411-git-send-email-aliguori@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756982AbXKGF5X@vger.kernel.org>
In-Reply-To: <11944039492411-git-send-email-aliguori@us.ibm.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: virtualization@lists.linux-foundation.org
Cc: Anthony Liguori <aliguori@us.ibm.com>, linux-kernel@vger.kernel.org, Rusty Russell <rusty@rusycorp.com.au>, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Wednesday 07 November 2007 13:52:29 Anthony Liguori wrote:
> This patch fixes a typo in vring_init(). 

Thanks, applied.

I've put it in the new, experimental virtio git tree on git.kernel.org.

Cheers,
Rusty.
