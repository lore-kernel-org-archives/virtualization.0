From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 1 of 1] x86_64: Put .note.* sections into a PT_NOTE segment
	in vmlinux
Date: Tue, 22 Aug 2006 08:11:26 -0700
Message-ID: <44EB1E9E.5030307@goop.org>
References: <1156256777.5091.93.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <1156256777.5091.93.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Ian Campbell <Ian.Campbell@xensource.com>
Cc: Andrew Morton <akpm@osdl.org>, Ian Pratt <ian.pratt@xensource.com>, Xen-devel <xen-devel@lists.xensource.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Chris Wright <chrisw@sous-sol.org>, Virtualization <virtualization@lists.osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Christoph Lameter <clameter@sgi.com>
List-Id: virtualization@lists.linuxfoundation.org

Ian Campbell wrote:
> It has been suggested to me that the notes segment should have flags 0
> (i.e. not readable) since it is only used by the loader and is not used
> at runtime. For now I went with a readable segment since that is what
> the i386 patch uses.
>   =


Note that the PT_NOTEs segment is aliased to a part of one of the =

PT_LOADs - ie, it points into the data segment.  So making it -rwx would =

either be ignored, or also require putting the bits into a new PT_LOAD =

segment with 0 permissions, which is pretty pointless.  I made it R_E =

just so there was no permissions conflict, though the _E part could =

probably go.

    J
