From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 10/28] i386: map enough initial memory to create lowmem
 mappings
Date: Wed, 25 Apr 2007 15:52:36 -0700
Message-ID: <462FDBB4.8020604@goop.org>
References: <20070414204154.871250608@goop.org>	<200704192250.52633.ak@suse.de>
	<4627D756.5020405@zytor.com>	<200704192304.01053.ak@suse.de>
	<4627DB0C.2010804@zytor.com>	<4627DDAD.4070805@redhat.com>
	<4627E099.209@goop.org>	<m1abwwqiof.fsf@ebiederm.dsl.xmission.com>
	<462FC8CD.1030505@goop.org>	<m11wi8qflo.fsf@ebiederm.dsl.xmission.com>
	<462FD0EF.5050706@goop.org>
	<m1tzv4p079.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <m1tzv4p079.fsf@ebiederm.dsl.xmission.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Chuck Ebbert <cebbert@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Eric W. Biederman wrote:
> Since you have PSE disabled for Xen my hunch is that somehow that
> got left on for your test boot.

No.  Under Xen cpuid masks out PSE (and complains if you try to set it
in a pte), but when booting native it will just use a plain unadorned cpuid.

    J
