From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next 3/3] vhost: access vq metadata through kernel
	virtual address
Date: Sat, 15 Dec 2018 13:15:06 -0800 (PST)
Message-ID: <20181215.131506.1592727721701772545.davem@davemloft.net>
References: <20181213101022.12475-4-jasowang@redhat.com>
	<20181213102713-mutt-send-email-mst@kernel.org>
	<d70c5ac1-c805-cefd-ace1-643a2e271ba0@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <d70c5ac1-c805-cefd-ace1-643a2e271ba0@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: jasowang@redhat.com
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

From: Jason Wang <jasowang@redhat.com>
Date: Fri, 14 Dec 2018 11:57:35 +0800

> This is the price of all GUP users not only vhost itself. What's more
> important, the goal is not to be left too much behind for other
> backends like DPDK or AF_XDP (all of which are using GUP).

+1
