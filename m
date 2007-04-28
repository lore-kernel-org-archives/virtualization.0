From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH] i386: introduce voyager smp_ops, fix voyager build
Date: Sat, 28 Apr 2007 15:53:56 -0600
Message-ID: <m14pn0dv2j.fsf@ebiederm.dsl.xmission.com>
References: <463382E5.9060701@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <463382E5.9060701@goop.org> (Jeremy Fitzhardinge's message of
	"Sat, 28 Apr 2007 10:22:45 -0700")
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
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge <jeremy@goop.org> writes:

> This adds an smp_ops for voyager, and hooks things up appropriately.
> This is the first baby-step to making subarch runtime switchable.


Unless I have missed something early_gdt_descr still needs to be updated. 

Eric
