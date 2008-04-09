From: Amit Shah <amit.shah@qumranet.com>
Subject: Re: [PATCH] use NR_IRQS for irq count
Date: Wed, 9 Apr 2008 10:13:10 +0530
Message-ID: <200804091013.11149.amit.shah__46561.1279978932$1207716394$gmane$org@qumranet.com>
References: <12076742761764-git-send-email-gcosta@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <12076742761764-git-send-email-gcosta@redhat.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Glauber Costa <gcosta@redhat.com>
Cc: kvm-devel@lists.sourceforge.net, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

* On Tuesday 08 April 2008 22:34:36 Glauber Costa wrote:
> Instead of artificially limiting irq numbers, use arch provided NR_IRQS
>
> Signed-off-by: Glauber Costa <gcosta@redhat.com>

Thanks, applied.

Going forward, we're going to use the in-kernel approach for interrupt 
injection (which already has this change). The irqhook module will stay 
around for testing / debugging purposes (will be used with -no-kvm-irqchip).

Amit.
