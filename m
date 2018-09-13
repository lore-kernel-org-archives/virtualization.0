From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net-next V2 00/11] vhost_net TX batching
Date: Thu, 13 Sep 2018 14:02:13 -0400
Message-ID: <20180913135833-mutt-send-email-mst__328.798700548028$1536861614$gmane$org@kernel.org>
References: <20180912031709.14112-1-jasowang@redhat.com>
	<20180913.092819.2099750169529223026.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180913.092819.2099750169529223026.davem@davemloft.net>
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
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Sep 13, 2018 at 09:28:19AM -0700, David Miller wrote:
> From: Jason Wang <jasowang@redhat.com>
> Date: Wed, 12 Sep 2018 11:16:58 +0800
> 
> > This series tries to batch submitting packets to underlayer socket
> > through msg_control during sendmsg(). This is done by:
>  ...
> 
> Series applied, thanks Jason.

Going over it now I don't see a lot to complain about, but I'd
appreciate a bit more time for review in the future. 3 days ok?

-- 
MST
