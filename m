From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: changing definition of paravirt_ops.iret
Date: Mon, 21 May 2007 17:53:14 +0100
Message-ID: <4651CE7A.40904@goop.org>
References: <4651C865.9090605@goop.org>
	<20070521164636.GC3429@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070521164636.GC3429@sequoia.sous-sol.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Chris Wright <chrisw@sous-sol.org>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Chris Wright wrote:
> This is definitely ad-hoc semantic change, but I don't see a beter
> way to do it (other than have iret be restore_regs_and_iret, which
> isn't really an improvement).

I just realized its a bit nastier than that.  There's also the issue of
removing the error_code from the stack, which is above %fs.  So it
becomes "restore %fs, remove error_code and iret".

Also, the INTERRUPT_RETURN in nmi_espfix_stack needs us to actually push
%fs and an error code, just so that it can be removed (but I have no
idea whether this is actually correct; it's very much Zach territory).

    J
