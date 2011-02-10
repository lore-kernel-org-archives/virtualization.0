From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] virtio_net: Add schedule check to napi_enable call
Date: Thu, 10 Feb 2011 11:03:46 -0800 (PST)
Message-ID: <20110210.110346.71098400.davem__4195.98477096788$1297364712$gmane$org@davemloft.net>
References: <201102101232.50526.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <201102101232.50526.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: rusty@rustcorp.com.au
Cc: herbert@gondor.hengli.com.au, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

From: Rusty Russell <rusty@rustcorp.com.au>
Date: Thu, 10 Feb 2011 12:32:50 +1030

> From: "Bruce Rogers" <brogers@novell.com>
> 
> Under harsh testing conditions, including low memory, the guest would
> stop receiving packets. With this patch applied we no longer see any
> problems in the driver while performing these tests for extended periods
> of time.
> 
> Make sure napi is scheduled subsequent to each napi_enable.
> 
> Signed-off-by: Bruce Rogers <brogers@novell.com>
> Signed-off-by: Olaf Kirch <okir@suse.de>
> Cc: stable@kernel.org
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

Applied, thanks everyone.
