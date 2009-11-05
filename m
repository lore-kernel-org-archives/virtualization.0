From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv6 1/3] tun: export underlying socket
Date: Thu, 5 Nov 2009 12:30:43 +0100
Message-ID: <200911051230.43272.arnd__10937.0277416476$1257420873$gmane$org@arndb.de>
References: <cover.1257193660.git.mst@redhat.com>
	<200911041909.06054.arnd@arndb.de>
	<20091104190523.GA772@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20091104190523.GA772@redhat.com>
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
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, s.hetze@linux-ag.com, hpa@zytor.com, mingo@elte.hu, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wednesday 04 November 2009, Michael S. Tsirkin wrote:
> > 
> > Michael, you didn't reply on this comment and the code is still there in v8.
> > Do you actually need this? What for?
> > 
> >       Arnd <><
> 
> Sorry, missed the question. If you look closely it is not exported for
> !__KERNEL__ at all.  The stub is for when CONFIG_TUN is undefined.
> Maybe I'll add a comment near #else, even though this is a bit strange
> since the #if is just 2 lines above it.

Ah right, I'm just blind.

Don't bother changing it then, the code looks good as it is.

	Arnd <><
