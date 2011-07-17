From: David Miller <davem@davemloft.net>
Subject: Re: [PATCHv9] vhost: experimental tx zero-copy support
Date: Sun, 17 Jul 2011 12:53:14 -0700 (PDT)
Message-ID: <20110717.125314.2233794351034635919.davem__24876.6750832603$1310932433$gmane$org@davemloft.net>
References: <20110717193540.GA29392@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20110717193540.GA29392@redhat.com>
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
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Sun, 17 Jul 2011 22:36:14 +0300

> The below is what I came up with. We add the feature enabled
> by default ...

s/enabled/disabled/  Well, at least you got it right in the
commit message where it counts :-)
