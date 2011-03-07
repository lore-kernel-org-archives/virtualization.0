From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vhost: copy_from_user -> __copy_from_user
Date: Mon, 7 Mar 2011 08:30:15 +0200
Message-ID: <20110307063014.GA11330__6296.94302701882$1299479482$gmane$org@redhat.com>
References: <20110306113349.GA24333@redhat.com>
	<20110306.180339.193718218.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110306.180339.193718218.davem@davemloft.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Mar 06, 2011 at 06:03:39PM -0800, David Miller wrote:
> From: "Michael S. Tsirkin" <mst@redhat.com>
> Date: Sun, 6 Mar 2011 13:33:49 +0200
> 
> > copy_from_user is pretty high on perf top profile,
> > replacing it with __copy_from_user helps.
> > It's also safe because we do access_ok checks during setup.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Is Rusty going to take this or should I?

Sorry about not making this clear.  I'll give it a day or two for review
then put it on the vhost tree myself.
Thanks!
