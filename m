From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH] virtio-spec: fix thinko in multiport documentation
Date: Mon, 10 Sep 2012 02:28:44 +0530
Message-ID: <20120909205844.GJ16985@amit.redhat.com>
References: <20120909110837.GA2395@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20120909110837.GA2395@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On (Sun) 09 Sep 2012 [14:08:37], Michael S. Tsirkin wrote:
> spec numbers ports port0, port 1 etc, then goes on to say
> "ports 2 onwards only if MULTIPORT is set".
> An obvious thinko, should be port 1 onwards.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: Amit Shah <amit.shah@redhat.com>

		Amit
