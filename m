From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] Fix AF_PACKET ABI breakage in 4.2
Date: Wed, 23 Sep 2015 11:09:26 -0700 (PDT)
Message-ID: <20150923.110926.1369752430685358746.davem__2316.63314993984$1443031800$gmane$org@davemloft.net>
References: <1443019470.74600.6.camel@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1443019470.74600.6.camel@infradead.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: dwmw2@infradead.org
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-api@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

From: David Woodhouse <dwmw2@infradead.org>
Date: Wed, 23 Sep 2015 15:44:30 +0100

> +#define VIO_LE virtio_legacy_is_little_endian()

When you define a shorthand macro, the defines to a function call,
make the macro have parenthesis too.
