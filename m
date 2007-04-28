From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH] i386: introduce voyager smp_ops, fix voyager build
Date: Sat, 28 Apr 2007 13:34:27 -0500
Message-ID: <1177785267.3688.58.camel@mulgrave.il.steeleye.com>
References: <463382E5.9060701@goop.org>  <200704282022.11321.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200704282022.11321.ak@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andi Kleen <ak@suse.de>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, 2007-04-28 at 20:22 +0200, Andi Kleen wrote:
> On Saturday 28 April 2007 19:22:45 Jeremy Fitzhardinge wrote:
> > This adds an smp_ops for voyager, and hooks things up appropriately.
> > This is the first baby-step to making subarch runtime switchable.
> 
> James, does it actually work?

It will take me a while to tell you ... would you believe I'm currently
bisecting for a voyager regression in 2.6.21 ...? ;-)

James
