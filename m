From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio_console: avoid config access from irq
Date: Wed, 4 Mar 2015 11:14:36 +0100
Message-ID: <20150304101436.GB26213@redhat.com>
References: <1425145305-27917-1-git-send-email-mst@redhat.com>
	<20150302055625.GE26196@grmbl.mre> <87fv9lk35x.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87fv9lk35x.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Amit Shah <amit.shah@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Mar 04, 2015 at 11:08:18AM +1030, Rusty Russell wrote:
> Amit Shah <amit.shah@redhat.com> writes:
> > On (Sat) 28 Feb 2015 [18:42:25], Michael S. Tsirkin wrote:
> >> when multiport is off, virtio console invokes config access from irq
> >> context, config access is blocking on s390.
> >> Fix this up by scheduling work from config irq - similar to what we do
> >> for multiport configs.
> >> 
> >> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >
> > Reviewed-by: Amit Shah <amit.shah@redhat.com>
> 
> Applied, thanks.
> 
> Should these be CC: stable?
> 
> Cheers,
> Rusty.

Yes, you are right.
