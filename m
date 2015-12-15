From: "Luis R. Rodriguez" <mcgrof@suse.com>
Subject: Re: [Xen-devel] kasan_map_early_shadow() on Xen
Date: Tue, 15 Dec 2015 12:02:44 -0800
Message-ID: <CAB=NE6VyUf=9NVvoU67wL=2GubgO9CL+cK3NVzuaw9uNw8f+DA__16853.3016847961$1450209809$gmane$org@mail.gmail.com>
References: <CAB=NE6Xs5fepzNtymzT4CueeJZ0KMPETpda114DpL4eMtDswtw@mail.gmail.com>
	<54F5B3DA.70203@samsung.com> <20150303141650.GA30332@l.oracle.com>
	<54F5D56C.6020803@samsung.com> <20150303160231.GA3518@l.oracle.com>
	<54F71861.9050702@samsung.com>
	<CAB=NE6WxNfxsqnv9MBpoL1=umdNReUCbM_dnxROjeY9J1Q-U_Q@mail.gmail.com>
	<20150306160249.GA8510@l.oracle.com>
	<20150306164754.GD25035@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150306164754.GD25035@wotan.suse.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Andrey Ryabinin <a.ryabinin@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>, Chris Wright <chrisw@sous-sol.org>, xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, virtualization@lists.linux-foundation.org, Alok Kataria <akataria@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Mar 6, 2015 at 8:47 AM, Luis R. Rodriguez <mcgrof@suse.com> wrote:
> If I had a technical solution to this problem I'd propose it but I don't,
> I'm just flagging it right now and hope we can come up with one.

Shortly I'll be posting part of a proactive solution I believe we
could consider for these sorts of issues.

 Luis
