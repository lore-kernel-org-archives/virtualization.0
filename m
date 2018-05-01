From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] vhost: make msg padding explicit
Date: Tue, 01 May 2018 11:28:22 -0400 (EDT)
Message-ID: <20180501.112822.1871426720257639849.davem__6098.35725413195$1525188387$gmane$org@davemloft.net>
References: <1524844881-178524-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1524844881-178524-1-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com
Cc: kevin@guarana.org, kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Fri, 27 Apr 2018 19:02:05 +0300

> There's a 32 bit hole just after type. It's best to
> give it a name, this way compiler is forced to initialize
> it with rest of the structure.
> 
> Reported-by: Kevin Easton <kevin@guarana.org>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Michael, will you be sending this directly to Linus or would you like
me to apply it to net or net-next?

Thanks.
