From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vhost: make msg padding explicit
Date: Wed, 2 May 2018 17:19:27 +0300
Message-ID: <20180502171909-mutt-send-email-mst@kernel.org>
References: <20180501.140551.1944561534446599966.davem@davemloft.net>
	<20180502062809.GA14485@la.guarana.org>
	<20180502162932-mutt-send-email-mst@kernel.org>
	<20180502.100446.106883595468297057.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180502.100446.106883595468297057.davem@davemloft.net>
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
Cc: kevin@guarana.org, kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, May 02, 2018 at 10:04:46AM -0400, David Miller wrote:
> From: "Michael S. Tsirkin" <mst@redhat.com>
> Date: Wed, 2 May 2018 16:36:37 +0300
> 
> > Ouch.  True - and in particular the 32 bit ABI on 64 bit kernels doesn't
> > work at all. Hmm. It's relatively new and maybe there aren't any 32 bit
> > users yet. Thoughts?
> 
> If it's been in a released kernel version, we really aren't at liberty
> to play "maybe nobody uses this" UAPI changing games.
> 
> Please send me a revert.

Sent. Looking at compat mess now.

-- 
MST
