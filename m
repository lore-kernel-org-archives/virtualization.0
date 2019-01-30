From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net] vhost: fix OOB in get_rx_bufs()
Date: Tue, 29 Jan 2019 20:36:31 -0500
Message-ID: <20190129203157-mutt-send-email-mst__7791.3820090302$1548826210$gmane$org@kernel.org>
References: <20190128.225444.1929870241029842289.davem@davemloft.net>
	<20190129175145-mutt-send-email-mst@kernel.org>
	<20190129.151026.358327408932275252.davem@davemloft.net>
	<20190129.153810.493942539151548676.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190129.153810.493942539151548676.davem@davemloft.net>
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
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, stefanha@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jan 29, 2019 at 03:38:10PM -0800, David Miller wrote:
> From: David Miller <davem@davemloft.net>
> Date: Tue, 29 Jan 2019 15:10:26 -0800 (PST)
> 
> > Yeah the CVE pushed my hand a little bit, and I knew I was going to
> > send Linus a pull request today because David Watson needs some TLS
> > changes in net-next.
> 
> I also want to make a general comment.... for the record.
> 
> If I let patches slip consistently past 24 hours my backlog is
> unmanageable.  Even with aggressively applying things quickly I'm
> right now at 70-75.  If I do not do what I am doing, then it's in the
> 100-150 range.
> 
> So I am at the point where I often must move forward with patches that
> I think I personally can verify and vet on my own.

If it helps I can include most virtio stuff in my pull requests instead.
Or if that can't work since there's too often a dependency on net-next,
maybe Jason wants to create a tree and send pull requests to you.  Let
us know if that will help, and which of the options looks better from
your POV.

-- 
MST
