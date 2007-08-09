From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [Lguest] Introducing paravirt_ops for x86_64
Date: Thu, 9 Aug 2007 08:46:30 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0708090843160.29847@gandalf.stny.rr.com>
References: <11865467522495-git-send-email-gcosta@redhat.com>
	<97D612E30E1F88419025B06CB4CF1BE10326E129@scsmsx412.amr.corp.intel.com>
	<5d6222a80708080758t1b937d0ej14c5e60ac23a20c5@mail.gmail.com>
	<46BAA799.7080806@goop.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46BAA799.7080806@goop.org>
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
Cc: lguest@ozlabs.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, anthony@codemonkey.ws, akpm@linux-foundation.org, Glauber de Oliveira Costa <gcosta@redhat.com>, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org


--
On Wed, 8 Aug 2007, Jeremy Fitzhardinge wrote:

>
> At the moment Xen can't support guests with 2M pages.  In 32-bit this
> isn't a huge problem, since the kernel doesn't assume it can map itself
> with 2M pages.  But I think the 64-bit kernel assumes 2M pages are
> always available for mapping the kernel.  I don't know how pervasive
> this assumption is, but it would be nice to parameterize it in pv-ops.
>

I got 2M pages working in lguest64, but it was a cause of a lot of pain.
By removing support for 2M pages in guests, that might clean up a lot of
lguest64 shadow paging as well.

The only advantage I see for 2M pages or a guest, is that it saves the
guest from having extra page tables. The host still needs the map the 2M
to 4K, so it's not an advantage there. It doesn't speed anything up, so
I'd be all for scrapping 2M pages for guests.

-- Steve
