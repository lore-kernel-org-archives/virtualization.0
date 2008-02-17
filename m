From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 4/5] [PATCH] introduce paravirt helpers
Date: Sun, 17 Feb 2008 19:05:09 +0100
Message-ID: <20080217180509.GW6006@elte.hu>
References: <1202757365-18634-1-git-send-email-gcosta@redhat.com>
	<1202757365-18634-2-git-send-email-gcosta@redhat.com>
	<1202757365-18634-3-git-send-email-gcosta@redhat.com>
	<1202757365-18634-4-git-send-email-gcosta@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1202757365-18634-4-git-send-email-gcosta@redhat.com>
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
Cc: ehabkost@redhat.com, shai@scalemp.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, kiran@scalemp.com, anthony@codemonkey.ws, akpm@linux-foundation.org, tglx@linutronix.de, ak@suse.de
List-Id: virtualization@lists.linuxfoundation.org


* Glauber Costa <gcosta@redhat.com> wrote:

>  config X86_VSMP
>  	bool "Support for ScaleMP vSMP"
>  	depends on X86_64 && PCI
> -	 help
> +	select PARAVIRT
> +	help

hm, what's the idea here?

	Ingo
