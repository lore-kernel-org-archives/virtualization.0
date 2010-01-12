From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 03/31] hvc_console: make the ops pointer const.
Date: Tue, 12 Jan 2010 22:06:34 +1030
Message-ID: <201001122206.34252.rusty__8320.80106852136$1263297285$gmane$org@rustcorp.com.au>
References: <1261492481-19817-1-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-4-git-send-email-amit.shah@redhat.com>
	<1263262906.724.175.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1263262906.724.175.camel@pasglop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Amit Shah <amit.shah@redhat.com>, linuxppc-dev@ozlabs.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 12 Jan 2010 12:51:46 pm Benjamin Herrenschmidt wrote:
> On Tue, 2009-12-22 at 20:04 +0530, Amit Shah wrote:
> > From: Rusty Russell <rusty@rustcorp.com.au>
> > 
> > This is nicer for modern R/O protection.  And noone needs it non-const, so
> > constify the callers as well.
> 
> Rusty, do you want me to take these via powerpc ?

Sure, thanks.

Rusty.
