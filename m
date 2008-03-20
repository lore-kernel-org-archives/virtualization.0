From: Tim Post <echo@echoreply.us>
Subject: Re: [Lguest] [RFC PATCH 1/5] lguest: mmap backing file
Date: Thu, 20 Mar 2008 16:16:00 +0800
Message-ID: <1206000960.6873.124.camel__30662.4725614258$1206024800$gmane$org@localhost.localdomain>
References: <200803201659.14344.rusty@rustcorp.com.au>
	<200803201705.44422.rusty@rustcorp.com.au>
Reply-To: echo@echoreply.us
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200803201705.44422.rusty@rustcorp.com.au>
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
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, lguest <lguest@ozlabs.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2008-03-20 at 17:05 +1100, Rusty Russell wrote:
> +       snprintf(memfile_path, PATH_MAX, "%s/.lguest",
> getenv("HOME") ?: "");

Hi Rusty,

Is that safe if being run via setuid/gid or shared root? It might be
better to just look it up in /etc/passwd against the real UID,
considering that anyone can change (or null) that env string.

Of course its also practical to just say "DON'T RUN LGUEST AS
SETUID/GID". Even if you say that, someone will do it. You might also
add beware of sudoers.

For people (like myself and lab mates) who are forced to share machines,
it could breed a whole new strain of practical jokes :)

That will cause lguest to inherit a memory leak from getpwuid(), but it
only leaks once.

Cheers,
--Tim
