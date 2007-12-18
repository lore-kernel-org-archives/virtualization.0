From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 3/21] [PATCH] move desc_empty to where they belong
Date: Tue, 18 Dec 2007 16:14:36 +1100
Message-ID: <200712181614.37890.rusty__30552.6667311371$1197955011$gmane$org@rustcorp.com.au>
References: <11979319641796-git-send-email-gcosta@redhat.com>
	<11979319763641-git-send-email-gcosta@redhat.com>
	<11979319811234-git-send-email-gcosta@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11979319811234-git-send-email-gcosta@redhat.com>
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
To: Glauber de Oliveira Costa <gcosta@redhat.com>
Cc: ehabkost@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, tglx@linutronix.de, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, mingo@elte.hu, roland@redhat.com, ak@suse.de
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday 18 December 2007 09:52:26 Glauber de Oliveira Costa wrote:
> +static inline int desc_empty(const void *ptr)
> +{
> +	const u32 *desc = ptr;
> +	return !(desc[0] | desc[1]);
> +}

Erk. This really needs to be a union, not a void *.  I guess we can clean it 
later.

Rusty.
