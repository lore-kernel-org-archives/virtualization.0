From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [Qemu-devel] custom virt-io support (in user-mode-linux)
Date: Fri, 24 May 2019 11:54:26 +0200
Message-ID: <aa9490ff07c587b3bca01ec5eb33d59ea440b645.camel@sipsolutions.net>
References: <0952696452f5ff4e38d2417029243fc60efa33d6.camel@sipsolutions.net>
	<20190523115950.GH26632@stefanha-x1.localdomain>
	<41d64b8971a097d1568f947517b45d09c156ccc8.camel@sipsolutions.net>
	<CAJSP0QWSZXT3OJAc=abagD40xZ7DWWrcP_+AwVBuqQyQNgaOEg@mail.gmail.com>
	(sfid-20190523_164131_760945_C45BA0A2)
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAJSP0QWSZXT3OJAc=abagD40xZ7DWWrcP_+AwVBuqQyQNgaOEg@mail.gmail.com>
	(sfid-20190523_164131_760945_C45BA0A2)
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: ido@wizery.com, linux-um@lists.infradead.org, qemu-devel <qemu-devel@nongnu.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2019-05-23 at 15:41 +0100, Stefan Hajnoczi wrote:

> > Also, not sure I understand how the client is started?
> 
> The vhost-user device backend can be launched before QEMU.  QEMU is
> started with the UNIX domain socket path so it can connect.

Hmm. I guess I'm confusing the terminology then - I thought qemu was the
server and the backend was the client that connects to it. If it's the
other way around, yeah, that makes things easier and certainly makes
sense (you could have a daemon that implements something).

> QEMU itself doesn't fork+exec the vhost-user device backend.  It's
> expected that the user or the management stack has already launched
> the vhost-user device backend.

Right.

> > Do you know if there's a sample client/server somewhere?
> 
> See contrib/libvhost-user in the QEMU source tree as well as the
> vhost-user-blk and vhost-user-scsi examples in the contrib/ directory.

Awesome, thanks!

johannes
