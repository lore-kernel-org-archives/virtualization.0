From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 3/3] checkpatch: add virt barriers
Date: Mon, 04 Jan 2016 14:11:37 -0800
Message-ID: <1451945497.4334.107.camel__40961.8445010439$1451945531$gmane$org@perches.com>
References: <1451907395-15978-1-git-send-email-mst@redhat.com>
	<1451907395-15978-4-git-send-email-mst@redhat.com>
	<1451926073.4334.90.camel@perches.com>
	<20160104230528-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160104230528-mutt-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, virtualization@lists.linux-foundation.org, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, Tony Lindgren <tony@atomide.com>, xen-devel@lists.xenproject.org, Ingo Molnar <mingo@elte.hu>, linux-xtensa@linux-xtensa.org, user-mode-linux-devel@lists.sourceforge.net, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Andrey Konovalov <andreyknvl@google.com>, adi-buildroot-devel@lists.sourceforge.net, "Cc : Andy Whitcroft" <apw@canonical.com>, Thomas Gleixner <tglx@linutronix.de>, linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Andrew
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2016-01-04 at 23:07 +0200, Michael S. Tsirkin wrote:
> On Mon, Jan 04, 2016 at 08:47:53AM -0800, Joe Perches wrote:
> > On Mon, 2016-01-04 at 13:37 +0200, Michael S. Tsirkin wrote:
> > > Add virt_ barriers to list of barriers to check for
> > > presence of a comment.
> > =

> > Are these virt_ barriers used anywhere?
> > =

> > I see some virtio_ barrier like uses.
> =

> They will be :) They are added and used by patchset
> 	=A0=A0=A0=A0=A0=A0=A0=A0arch: barrier cleanup + barriers for virt
> =

> See
> http://article.gmane.org/gmane.linux.kernel.virtualization/26555

Ah, OK, thanks.

Are the virtio_ barriers going away?
If not, maybe those should be added too.
