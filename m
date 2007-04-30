From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH] i386: introduce voyager smp_ops, fix voyager build
Date: Mon, 30 Apr 2007 13:23:26 -0500
Message-ID: <1177957406.3674.48.camel@mulgrave.il.steeleye.com>
References: <463382E5.9060701@goop.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <463382E5.9060701@goop.org>
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
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, 2007-04-28 at 10:22 -0700, Jeremy Fitzhardinge wrote:
> This adds an smp_ops for voyager, and hooks things up appropriately.
> This is the first baby-step to making subarch runtime switchable.

This sort of works, but there's something strange going on with it and
andi's entire series.  It now dies loading the SCSI modules in the error
handling thread ... I assume we have some API conflict ... I'll
investigate.

The other problem is it conflicts with an existing voyager patch:

http://git.kernel.org/?p=linux/kernel/git/jejb/voyager-2.6.git;a=commit;h=0293ca814b74e20e77cf719074ee15372204fc55

But I've got that fixed up.

James
