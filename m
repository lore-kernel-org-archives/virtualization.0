From: Avi Kivity <avi@qumranet.com>
Subject: Re: [PATCH] make setup_secondary_clock definition dependent on local
	apic
Date: Sun, 04 May 2008 14:48:55 +0300
Message-ID: <481DA2A7.6090302__39760.2631048814$1209901874$gmane$org@qumranet.com>
References: <12095699453538-git-send-email-gcosta@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <12095699453538-git-send-email-gcosta@redhat.com>
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
Cc: kvm-devel@lists.sourceforge.net, mingo@elte.hu, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Glauber Costa wrote:
> since the pv_apic_ops are only present if CONFIG_X86_LOCAL_APIC is compiled
> in, kvmclock failed to build without this option. This patch fixes this
>
>   

Applied, thanks.

-- 
error compiling committee.c: too many arguments to function
