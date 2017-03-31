From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/2] virtio: allow drivers to validate features
Date: Fri, 31 Mar 2017 06:27:04 +0300
Message-ID: <20170331062634-mutt-send-email-mst__38174.5901577689$1490930846$gmane$org@kernel.org>
References: <1490807652-27889-1-git-send-email-mst@redhat.com>
	<20170330.123931.210255819001973026.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20170330.123931.210255819001973026.davem@davemloft.net>
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
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 30, 2017 at 12:39:31PM -0700, David Miller wrote:
> From: "Michael S. Tsirkin" <mst@redhat.com>
> Date: Wed, 29 Mar 2017 20:14:44 +0300
> 
> > Some drivers can't support all features in all configurations.  At the
> > moment we blindly set FEATURES_OK and later FAILED.  Support this better
> > by adding a callback drivers can use to do some early checks.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Michael do you want me to take these virtio networking fixes into my
> tree directly or are you going to send me a pull request or something
> after it all settles down?
> 
> Thanks.

I think I'll send a pull request.

Thanks,

-- 
MST
