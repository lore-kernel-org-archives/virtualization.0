From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: virtio_net: another race with virtio_net and enable_cb
Date: Tue, 27 May 2008 12:25:51 +0200
Message-ID: <200805271225.51618.borntraeger__41261.0882115134$1211884180$gmane$org@de.ibm.com>
References: <200805261129.27718.borntraeger@de.ibm.com>
	<200805271236.00439.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200805271236.00439.rusty@rustcorp.com.au>
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
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Am Dienstag, 27. Mai 2008 schrieb Rusty Russell:
> You should be able to verify that you are hitting this window by putting a 
> printk in the !enable_cb && !napi_schedule_prep case.

Confirmed. I see this printk once in a while.
