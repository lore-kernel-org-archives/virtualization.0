From: Glauber Costa <gcosta@redhat.com>
Subject: Re: [PATCH] use NR_IRQS for irq count
Date: Wed, 09 Apr 2008 09:11:10 -0300
Message-ID: <47FCB25E.1070606@redhat.com>
References: <12076742761764-git-send-email-gcosta@redhat.com>
	<200804091013.11149.amit.shah@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200804091013.11149.amit.shah@qumranet.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@qumranet.com>
Cc: kvm-devel@lists.sourceforge.net, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Amit Shah wrote:
> * On Tuesday 08 April 2008 22:34:36 Glauber Costa wrote:
>> Instead of artificially limiting irq numbers, use arch provided NR_IRQS
>>
>> Signed-off-by: Glauber Costa <gcosta@redhat.com>
> 
> Thanks, applied.
> 
> Going forward, we're going to use the in-kernel approach for interrupt 
> injection (which already has this change). The irqhook module will stay 
> around for testing / debugging purposes (will be used with -no-kvm-irqchip).
> 
> Amit.
Is it already in your tree?
