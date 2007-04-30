From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 03/32] xen: Add nosegneg capability to the vsyscall page
 notes
Date: Sun, 29 Apr 2007 21:54:44 -0700
Message-ID: <46357694.2030206@goop.org>
References: <20070429190830.0CF571801A4@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070429190830.0CF571801A4@magilla.sf.frob.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Roland McGrath <roland@redhat.com>
Cc: Ian Pratt <ian.pratt@xensource.com>, lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, Ulrich Drepper <drepper@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Roland McGrath wrote:
> I wouldn't add that macro to asm/elf.h.  There is nothing magical or
> standard about that number.
>   

It was just there for a later patch to set/clear the mask dynamically
depending on whether we're running under Xen.  But I haven't implemented
that yet.

    J
