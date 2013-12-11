From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next 2/3] virtio_net: remove unused parameter to
	send_command
Date: Tue, 10 Dec 2013 22:28:33 -0500 (EST)
Message-ID: <20131210.222833.203879336646691401.davem__28153.0442568057$1386732528$gmane$org@davemloft.net>
References: <20131209161632.5ac96e5a@nehalam.linuxnetplumber.net>
	<20131209161740.5f2cfae7@nehalam.linuxnetplumber.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20131209161740.5f2cfae7@nehalam.linuxnetplumber.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: stephen@networkplumber.org
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

From: Stephen Hemminger <stephen@networkplumber.org>
Date: Mon, 9 Dec 2013 16:17:40 -0800

> All the code passes NULL for the last sg list (in).
> Simplify by just removing it.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Applied.
