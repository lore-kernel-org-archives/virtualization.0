From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next] vhost: switch to use new message format
Date: Sat, 04 Aug 2018 13:21:10 -0700 (PDT)
Message-ID: <20180804.132110.184608716461100739.davem@davemloft.net>
References: <1533279891-12249-1-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1533279891-12249-1-git-send-email-jasowang@redhat.com>
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
Date: Fri,  3 Aug 2018 15:04:51 +0800

> So fixing this by introducing a new message type with an explicit
> 32bit reserved field after type like:
> 
> struct vhost_msg_v2 {
> 	int type;
> 	__u32 reserved;

Please use fixed sized types consistently.  Use 's32' instead of 'int'
here.

Thanks!
