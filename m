From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vhost: silence an unused-variable warning
Date: Sat, 9 Mar 2019 18:19:07 -0500
Message-ID: <20190309181754-mutt-send-email-mst__15204.8273872182$1552173561$gmane$org@kernel.org>
References: <20190306110602.2529137-1-arnd@arndb.de>
	<20190308.151726.1373226353046701716.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190308.151726.1373226353046701716.davem@davemloft.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Miller <davem@davemloft.net>
Cc: kvm@vger.kernel.org, arnd@arndb.de, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, stefanha@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Mar 08, 2019 at 03:17:26PM -0800, David Miller wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> Date: Wed,  6 Mar 2019 12:05:49 +0100
> 
> > On some architectures, the MMU can be disabled, leading to access_ok()
> > becoming an empty macro that does not evaluate its size argument,
> > which in turn produces an unused-variable warning:
> > 
> > drivers/vhost/vhost.c:1191:9: error: unused variable 's' [-Werror,-Wunused-variable]
> >         size_t s = vhost_has_feature(vq, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
> > 
> > Mark the variable as __maybe_unused to shut up that warning.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> I'll apply this, thanks Arnd.

I queued this for next linux already and it's been in linux-next
for a while. Sorry that I didn't reply, will try to remember to do it
next time.
