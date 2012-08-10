From: "Peter Huang(Peng)" <peter.huangpeng@huawei.com>
Subject: [Question]About KVM network zero-copy  feature!
Date: Fri, 10 Aug 2012 11:34:32 +0800
Message-ID: <50248148.4070204__25023.4090759934$1344634200$gmane$org@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm@vger.kernel.org, avi@redhat.com, mtosatti@redhat.com, mst@redhat.com, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Hi,All

I searched from git-log, and found that until now we have vhost TX zero-copy experiment feature, how
about RX zero-copy?

For XEN, net-back also only has TX zero-copy, Is there any reason that RX zero-copy still not implemented?

Thanks!
