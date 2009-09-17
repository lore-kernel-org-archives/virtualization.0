From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: vhost-net todo list
Date: Thu, 17 Sep 2009 17:08:47 +0200
Message-ID: <200909171708.47853.arnd__23171.0383705378$1253200293$gmane$org@arndb.de>
References: <20090916100438.GA30036@redhat.com>
	<200909171414.06527.arnd@arndb.de>
	<20090917122547.GA19089@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090917122547.GA19089@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, anthony@codemonkey.ws, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thursday 17 September 2009, Michael S. Tsirkin wrote:
> Well, we could have a char device with an ioctl that gives you back a socket,
> or maybe even have it give you back a socket when you open it.
> Will that make you happy?

Well, that would put is in the exact same spot as the tun/tap driver patch
you're working on or my (still unfinished, I need to spend some time on it
again) macvtap driver. As I said, either one addresses the problem but is
unrelated to the raw socket interface.

	Arnd <><
