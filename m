From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: changing definition of paravirt_ops.iret
Date: Mon, 21 May 2007 09:46:36 -0700
Message-ID: <20070521164636.GC3429@sequoia.sous-sol.org>
References: <4651C865.9090605@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4651C865.9090605@goop.org>
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
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

* Jeremy Fitzhardinge (jeremy@goop.org) wrote:
> I'm implementing a more efficient version of the Xen iret paravirt_op,
> so that it can use the real iret instruction where possible.  I really
> need to get access to per-cpu variables, so I can set the event mask
> state in the vcpu_info structure, but unfortunately at the point where
> INTERRUPT_RETURN is used in entry.S, the usermode %fs has already been
> restored.
> 
> How would you feel if we changed paravirt_ops.iret to make it also
> responsible for restoring %fs? 

This is definitely ad-hoc semantic change, but I don't see a beter
way to do it (other than have iret be restore_regs_and_iret, which
isn't really an improvement).

thanks,
-chris
