From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] vhost: copy_from_user -> __copy_from_user
Date: Sun, 06 Mar 2011 18:03:39 -0800 (PST)
Message-ID: <20110306.180339.193718218.davem__25308.884206652$1299463524$gmane$org@davemloft.net>
References: <20110306113349.GA24333@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20110306113349.GA24333@redhat.com>
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
Date: Sun, 6 Mar 2011 13:33:49 +0200

> copy_from_user is pretty high on perf top profile,
> replacing it with __copy_from_user helps.
> It's also safe because we do access_ok checks during setup.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Is Rusty going to take this or should I?
