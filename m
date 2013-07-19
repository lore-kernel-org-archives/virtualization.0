From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: is kexec on Xen domU possible?
Date: Fri, 19 Jul 2013 09:54:45 -0400
Message-ID: <20130719135445.GB12144@localhost.localdomain>
References: <20130719020603.GA22932@kroah.com>
	<20130719131819.GC11233@debian70-amd64.local.net-space.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20130719131819.GC11233@debian70-amd64.local.net-space.pl>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Daniel Kiper <daniel.kiper@oracle.com>, olaf@aepfle.de
Cc: xen-devel@lists.xensource.com, Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Eric Biederman <ebiederm@xmission.com>, Brandon Philips <brandon@ifup.org>
List-Id: virtualization@lists.linuxfoundation.org

Hey Daniel,

Thank you for the nice summary.

>   - PVonHVM guests: IIRC, there were some issues with PV
>     drivers but they were fixed some time ago by patches
>     posted by Olaf Hering,

Which had to be reverted b/c they caused regressions with
32-bit guests during migration. But Greg if you are just looking
to do it on a guest without migration then cherrypicking
 9d02b43dee0d7fb18dfb13a00915550b1a3daa9f
("xen PVonHVM: use E820_Reserved area for shared_info")
should do it for it.

Olaf, you wouldn't have any time to look at this some more now
that Xen 4.3 is out?
