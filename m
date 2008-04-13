From: Avi Kivity <avi@qumranet.com>
Subject: Re: [kvm-devel] [PATCH 1/2] KVM: Expose get_eoi_gsi() for IRQ acking
	by	PCI passthrough devices
Date: Sun, 13 Apr 2008 11:22:25 +0300
Message-ID: <4801C2C1.5060603__48447.3482509658$1208075162$gmane$org@qumranet.com>
References: <1207817334-31775-1-git-send-email-amit.shah@qumranet.com>
	<1207817334-31775-2-git-send-email-amit.shah@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1207817334-31775-2-git-send-email-amit.shah@qumranet.com>
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
Cc: chrisw@redhat.com, kvm-devel@lists.sourceforge.net, allen.m.kay@intel.com, virtualization@lists.linux-foundation.org, gcosta@redhat.com, BENAMI@il.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

Amit Shah wrote:
>  
> -static int get_eoi_gsi(struct kvm_ioapic *ioapic, int vector)
> +int get_eoi_gsi(struct kvm_ioapic *ioapic, int vector)
>   

Such a generic name should be prefixed by kvm_ if you expose it.

-- 
error compiling committee.c: too many arguments to function
