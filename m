From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net-next v2] drivers: net: virtio_net: Implement a
 dev_watchdog handler
Date: Sun, 24 Nov 2019 05:52:02 -0500
Message-ID: <20191124054916-mutt-send-email-mst__49576.0681618535$1574592749$gmane$org@kernel.org>
References: <20191122013636.1041-1-jcfaracco@gmail.com>
 <20191122052506-mutt-send-email-mst@kernel.org>
 <CAENf94KX1XR4_KXz9KLZQ09Ngeaq2qzYY5OE68xJMXMu13SuEg@mail.gmail.com>
 <20191122080233-mutt-send-email-mst@kernel.org>
 <CAENf94L7zU6JoM+19F+__b6W4mpe5Na=ayd+eYe4aZ+EBABmiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAENf94L7zU6JoM+19F+__b6W4mpe5Na=ayd+eYe4aZ+EBABmiA@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Julio Faracco <jcfaracco@gmail.com>
Cc: Daiane Mendes <dnmendes76@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Nov 23, 2019 at 08:33:40PM -0200, Julio Faracco wrote:
> >
> > netdev: pass the stuck queue to the timeout handler
> >
> > This allows incrementing the correct timeout statistic without any mess.
> > Down the road, devices can learn to reset just the specific queue.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> > Warning: untested.
> >
> 
> Question...
> Wouldn't be better to create a module parameter instead change the
> function scope?

Passing the value in a global variable? That fails to be reentrant ...

> I'm asking it because how many modules would effectively take advantage of it?

The cost is effectively 0 though.

-- 
MST
