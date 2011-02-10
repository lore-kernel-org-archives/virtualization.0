From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] virtio_net: Add schedule check to napi_enable call
Date: Thu, 10 Feb 2011 11:01:19 -0800 (PST)
Message-ID: <20110210.110119.226784284.davem__27072.0963752412$1297364485$gmane$org@davemloft.net>
References: <201102101232.50526.rusty@rustcorp.com.au>
	<20110210175725.GA9674@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20110210175725.GA9674@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com
Cc: herbert@gondor.hengli.com.au, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Thu, 10 Feb 2011 19:57:26 +0200

> On Thu, Feb 10, 2011 at 12:32:50PM +1030, Rusty Russell wrote:
>> From: "Bruce Rogers" <brogers@novell.com>
>> 
>> Under harsh testing conditions, including low memory, the guest would
>> stop receiving packets. With this patch applied we no longer see any
>> problems in the driver while performing these tests for extended periods
>> of time.
>> 
>> Make sure napi is scheduled subsequent to each napi_enable.
>> 
>> Signed-off-by: Bruce Rogers <brogers@novell.com>
>> Signed-off-by: Olaf Kirch <okir@suse.de>
>> Cc: stable@kernel.org
>> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> 
> Rusty, so this is 2.6.38 material - you'll send this to Linus? Or DaveM?

Don't worry I'll apply this to net-2.6, thanks.
