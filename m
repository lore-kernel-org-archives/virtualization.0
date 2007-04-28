From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] i386: introduce voyager smp_ops, fix voyager build
Date: Sat, 28 Apr 2007 20:22:11 +0200
Message-ID: <200704282022.11321.ak@suse.de>
References: <463382E5.9060701@goop.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1163288AbXD1SWX@vger.kernel.org>
In-Reply-To: <463382E5.9060701@goop.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rusty Russell <rusty@rustcorp.com.au>
List-Id: virtualization@lists.linuxfoundation.org

On Saturday 28 April 2007 19:22:45 Jeremy Fitzhardinge wrote:
> This adds an smp_ops for voyager, and hooks things up appropriately.
> This is the first baby-step to making subarch runtime switchable.

James, does it actually work?


-Andi
