From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH] virtio-spec: fix thinko in multiport documentation
Date: Wed, 12 Dec 2012 14:44:20 +0530
Message-ID: <20121212091420.GB21936@amit.redhat.com>
References: <20120909110837.GA2395@redhat.com>
	<20121212082224.GA3827@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20121212082224.GA3827@redhat.com>
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

On (Wed) 12 Dec 2012 [10:22:24], Michael S. Tsirkin wrote:
> On Sun, Sep 09, 2012 at 02:08:37PM +0300, Michael S. Tsirkin wrote:
> > spec numbers ports port0, port 1 etc, then goes on to say
> > "ports 2 onwards only if MULTIPORT is set".
> > An obvious thinko, should be port 1 onwards.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Rusty, Amit, any feedback?

http://thread.gmane.org/gmane.linux.kernel.virtualization/16973/focus=16980

		Amit
