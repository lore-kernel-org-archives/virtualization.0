From: kbuild test robot <lkp@intel.com>
Subject: [vhost:linux-next 12/12] drivers/vhost/vhost.c:1968:25: sparse:
 sparse: incompatible types in comparison expression (different type sizes):
Date: Mon, 16 Dec 2019 02:54:43 +0800
Message-ID: <201912160233.If8H2c51%lkp__45174.274598115$1576436133$gmane$org@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, kbuild-all@lists.01.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
head:   b072ae74df177c3ad7704c5fbe66e3f10aad9d4e
commit: b072ae74df177c3ad7704c5fbe66e3f10aad9d4e [12/12] vhost: use vhost_desc instead of vhost_log
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-101-g82dee2e-dirty
        git checkout b072ae74df177c3ad7704c5fbe66e3f10aad9d4e
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   drivers/vhost/vhost.c:763:17: sparse: sparse: incorrect type in return expression (different address spaces)
   drivers/vhost/vhost.c:763:17: sparse:    expected void [noderef] <asn:1> *
   drivers/vhost/vhost.c:763:17: sparse:    got void *
   drivers/vhost/vhost.c:763:17: sparse: sparse: incorrect type in return expression (different address spaces)
   drivers/vhost/vhost.c:763:17: sparse:    expected void [noderef] <asn:1> *
   drivers/vhost/vhost.c:763:17: sparse:    got void *
   drivers/vhost/vhost.c:763:17: sparse: sparse: incorrect type in return expression (different address spaces)
   drivers/vhost/vhost.c:763:17: sparse:    expected void [noderef] <asn:1> *
   drivers/vhost/vhost.c:763:17: sparse:    got void *
>> drivers/vhost/vhost.c:1968:25: sparse: sparse: incompatible types in comparison expression (different type sizes):
>> drivers/vhost/vhost.c:1968:25: sparse:    unsigned int *
>> drivers/vhost/vhost.c:1968:25: sparse:    unsigned long long *
   drivers/vhost/vhost.c:947:16: sparse: sparse: incorrect type in argument 2 (different address spaces)
   drivers/vhost/vhost.c:947:16: sparse:    expected void *addr
   drivers/vhost/vhost.c:947:16: sparse:    got restricted __virtio16 [noderef] <asn:1> *
   drivers/vhost/vhost.c:763:17: sparse: sparse: incorrect type in return expression (different address spaces)
   drivers/vhost/vhost.c:763:17: sparse:    expected void [noderef] <asn:1> *
   drivers/vhost/vhost.c:763:17: sparse:    got void *
   drivers/vhost/vhost.c:910:42: sparse: sparse: incorrect type in argument 2 (different address spaces)
   drivers/vhost/vhost.c:910:42: sparse:    expected void [noderef] <asn:1> *addr
   drivers/vhost/vhost.c:910:42: sparse:    got void *addr
   drivers/vhost/vhost.c:932:16: sparse: sparse: incorrect type in argument 2 (different address spaces)
   drivers/vhost/vhost.c:932:16: sparse:    expected void *addr
   drivers/vhost/vhost.c:932:16: sparse:    got restricted __virtio16 [noderef] [usertype] <asn:1> *
   drivers/vhost/vhost.c:763:17: sparse: sparse: incorrect type in return expression (different address spaces)
   drivers/vhost/vhost.c:763:17: sparse:    expected void [noderef] <asn:1> *
   drivers/vhost/vhost.c:763:17: sparse:    got void *
   drivers/vhost/vhost.c:910:42: sparse: sparse: incorrect type in argument 2 (different address spaces)
   drivers/vhost/vhost.c:910:42: sparse:    expected void [noderef] <asn:1> *addr
   drivers/vhost/vhost.c:910:42: sparse:    got void *addr
   drivers/vhost/vhost.c:1024:16: sparse: sparse: incorrect type in argument 2 (different address spaces)
   drivers/vhost/vhost.c:1024:16: sparse:    expected void *addr
   drivers/vhost/vhost.c:1024:16: sparse:    got restricted __virtio16 [noderef] <asn:1> *
   drivers/vhost/vhost.c:763:17: sparse: sparse: incorrect type in return expression (different address spaces)
   drivers/vhost/vhost.c:763:17: sparse:    expected void [noderef] <asn:1> *
   drivers/vhost/vhost.c:763:17: sparse:    got void *
   drivers/vhost/vhost.c:910:42: sparse: sparse: incorrect type in argument 2 (different address spaces)
   drivers/vhost/vhost.c:910:42: sparse:    expected void [noderef] <asn:1> *addr
   drivers/vhost/vhost.c:910:42: sparse:    got void *addr
   drivers/vhost/vhost.c:999:16: sparse: sparse: incorrect type in argument 2 (different address spaces)
   drivers/vhost/vhost.c:999:16: sparse:    expected void *addr
   drivers/vhost/vhost.c:999:16: sparse:    got restricted __virtio16 [noderef] <asn:1> *
   drivers/vhost/vhost.c:763:17: sparse: sparse: incorrect type in return expression (different address spaces)
   drivers/vhost/vhost.c:763:17: sparse:    expected void [noderef] <asn:1> *
   drivers/vhost/vhost.c:763:17: sparse:    got void *
   drivers/vhost/vhost.c:910:42: sparse: sparse: incorrect type in argument 2 (different address spaces)
   drivers/vhost/vhost.c:910:42: sparse:    expected void [noderef] <asn:1> *addr
   drivers/vhost/vhost.c:910:42: sparse:    got void *addr
   drivers/vhost/vhost.c:1005:16: sparse: sparse: incorrect type in argument 2 (different address spaces)
   drivers/vhost/vhost.c:1005:16: sparse:    expected void *addr
   drivers/vhost/vhost.c:1005:16: sparse:    got restricted __virtio16 [noderef] <asn:1> *
   drivers/vhost/vhost.c:763:17: sparse: sparse: incorrect type in return expression (different address spaces)
   drivers/vhost/vhost.c:763:17: sparse:    expected void [noderef] <asn:1> *
   drivers/vhost/vhost.c:763:17: sparse:    got void *
   drivers/vhost/vhost.c:910:42: sparse: sparse: incorrect type in argument 2 (different address spaces)
   drivers/vhost/vhost.c:910:42: sparse:    expected void [noderef] <asn:1> *addr
   drivers/vhost/vhost.c:910:42: sparse:    got void *addr
   drivers/vhost/vhost.c:954:16: sparse: sparse: incorrect type in argument 2 (different address spaces)
   drivers/vhost/vhost.c:954:16: sparse:    expected void *addr
   drivers/vhost/vhost.c:954:16: sparse:    got restricted __virtio16 [noderef] <asn:1> *
   drivers/vhost/vhost.c:763:17: sparse: sparse: incorrect type in return expression (different address spaces)
   drivers/vhost/vhost.c:763:17: sparse:    expected void [noderef] <asn:1> *
   drivers/vhost/vhost.c:763:17: sparse:    got void *
   drivers/vhost/vhost.c:910:42: sparse: sparse: incorrect type in argument 2 (different address spaces)
   drivers/vhost/vhost.c:910:42: sparse:    expected void [noderef] <asn:1> *addr
   drivers/vhost/vhost.c:910:42: sparse:    got void *addr
   drivers/vhost/vhost.c:1012:16: sparse: sparse: incorrect type in argument 2 (different address spaces)
   drivers/vhost/vhost.c:1012:16: sparse:    expected void *addr
   drivers/vhost/vhost.c:1012:16: sparse:    got restricted __virtio16 [noderef] <asn:1> *
   drivers/vhost/vhost.c:763:17: sparse: sparse: incorrect type in return expression (different address spaces)
   drivers/vhost/vhost.c:763:17: sparse:    expected void [noderef] <asn:1> *
   drivers/vhost/vhost.c:763:17: sparse:    got void *
   drivers/vhost/vhost.c:910:42: sparse: sparse: incorrect type in argument 2 (different address spaces)
   drivers/vhost/vhost.c:910:42: sparse:    expected void [noderef] <asn:1> *addr
   drivers/vhost/vhost.c:910:42: sparse:    got void *addr
   drivers/vhost/vhost.c:1018:16: sparse: sparse: incorrect type in argument 2 (different address spaces)
   drivers/vhost/vhost.c:1018:16: sparse:    expected void *addr
   drivers/vhost/vhost.c:1018:16: sparse:    got restricted __virtio16 [noderef] [usertype] <asn:1> *
   drivers/vhost/vhost.c:763:17: sparse: sparse: incorrect type in return expression (different address spaces)
   drivers/vhost/vhost.c:763:17: sparse:    expected void [noderef] <asn:1> *
   drivers/vhost/vhost.c:763:17: sparse:    got void *
   drivers/vhost/vhost.c:910:42: sparse: sparse: incorrect type in argument 2 (different address spaces)
   drivers/vhost/vhost.c:910:42: sparse:    expected void [noderef] <asn:1> *addr
   drivers/vhost/vhost.c:910:42: sparse:    got void *addr
   drivers/vhost/vhost.c:999:16: sparse: sparse: incorrect type in argument 2 (different address spaces)
   drivers/vhost/vhost.c:999:16: sparse:    expected void *addr
   drivers/vhost/vhost.c:999:16: sparse:    got restricted __virtio16 [noderef] <asn:1> *
   drivers/vhost/vhost.c:763:17: sparse: sparse: incorrect type in return expression (different address spaces)
   drivers/vhost/vhost.c:763:17: sparse:    expected void [noderef] <asn:1> *
   drivers/vhost/vhost.c:763:17: sparse:    got void *
   drivers/vhost/vhost.c:910:42: sparse: sparse: incorrect type in argument 2 (different address spaces)
   drivers/vhost/vhost.c:910:42: sparse:    expected void [noderef] <asn:1> *addr
   drivers/vhost/vhost.c:910:42: sparse:    got void *addr
   drivers/vhost/vhost.c:999:16: sparse: sparse: incorrect type in argument 2 (different address spaces)
   drivers/vhost/vhost.c:999:16: sparse:    expected void *addr
   drivers/vhost/vhost.c:999:16: sparse:    got restricted __virtio16 [noderef] <asn:1> *
   drivers/vhost/vhost.c:763:17: sparse: sparse: incorrect type in return expression (different address spaces)
   drivers/vhost/vhost.c:763:17: sparse:    expected void [noderef] <asn:1> *
   drivers/vhost/vhost.c:763:17: sparse:    got void *
   drivers/vhost/vhost.c:910:42: sparse: sparse: incorrect type in argument 2 (different address spaces)
   drivers/vhost/vhost.c:910:42: sparse:    expected void [noderef] <asn:1> *addr
   drivers/vhost/vhost.c:910:42: sparse:    got void *addr

vim +1968 drivers/vhost/vhost.c

cc5e710759470b Jason Wang         2019-01-16  1948  
b072ae74df177c Michael S. Tsirkin 2019-12-11  1949  int vhost_log_write(struct vhost_virtqueue *vq, struct vhost_desc *log,
cc5e710759470b Jason Wang         2019-01-16  1950  		    unsigned int log_num, u64 len, struct iovec *iov, int count)
3a4d5c94e95935 Michael S. Tsirkin 2010-01-14  1951  {
3a4d5c94e95935 Michael S. Tsirkin 2010-01-14  1952  	int i, r;
3a4d5c94e95935 Michael S. Tsirkin 2010-01-14  1953  
3a4d5c94e95935 Michael S. Tsirkin 2010-01-14  1954  	/* Make sure data written is seen before log. */
5659338c88963e Michael S. Tsirkin 2010-02-01  1955  	smp_wmb();
cc5e710759470b Jason Wang         2019-01-16  1956  
cc5e710759470b Jason Wang         2019-01-16  1957  	if (vq->iotlb) {
cc5e710759470b Jason Wang         2019-01-16  1958  		for (i = 0; i < count; i++) {
cc5e710759470b Jason Wang         2019-01-16  1959  			r = log_write_hva(vq, (uintptr_t)iov[i].iov_base,
cc5e710759470b Jason Wang         2019-01-16  1960  					  iov[i].iov_len);
cc5e710759470b Jason Wang         2019-01-16  1961  			if (r < 0)
cc5e710759470b Jason Wang         2019-01-16  1962  				return r;
cc5e710759470b Jason Wang         2019-01-16  1963  		}
cc5e710759470b Jason Wang         2019-01-16  1964  		return 0;
cc5e710759470b Jason Wang         2019-01-16  1965  	}
cc5e710759470b Jason Wang         2019-01-16  1966  
3a4d5c94e95935 Michael S. Tsirkin 2010-01-14  1967  	for (i = 0; i < log_num; ++i) {
3a4d5c94e95935 Michael S. Tsirkin 2010-01-14 @1968  		u64 l = min(log[i].len, len);
3a4d5c94e95935 Michael S. Tsirkin 2010-01-14  1969  		r = log_write(vq->log_base, log[i].addr, l);
3a4d5c94e95935 Michael S. Tsirkin 2010-01-14  1970  		if (r < 0)
3a4d5c94e95935 Michael S. Tsirkin 2010-01-14  1971  			return r;
3a4d5c94e95935 Michael S. Tsirkin 2010-01-14  1972  		len -= l;
5786aee8bf6d74 Michael S. Tsirkin 2010-09-22  1973  		if (!len) {
3a4d5c94e95935 Michael S. Tsirkin 2010-01-14  1974  			if (vq->log_ctx)
3a4d5c94e95935 Michael S. Tsirkin 2010-01-14  1975  				eventfd_signal(vq->log_ctx, 1);
5786aee8bf6d74 Michael S. Tsirkin 2010-09-22  1976  			return 0;
5786aee8bf6d74 Michael S. Tsirkin 2010-09-22  1977  		}
5786aee8bf6d74 Michael S. Tsirkin 2010-09-22  1978  	}
3a4d5c94e95935 Michael S. Tsirkin 2010-01-14  1979  	/* Length written exceeds what we have stored. This is a bug. */
3a4d5c94e95935 Michael S. Tsirkin 2010-01-14  1980  	BUG();
3a4d5c94e95935 Michael S. Tsirkin 2010-01-14  1981  	return 0;
3a4d5c94e95935 Michael S. Tsirkin 2010-01-14  1982  }
6ac1afbf6132df Asias He           2013-05-06  1983  EXPORT_SYMBOL_GPL(vhost_log_write);
3a4d5c94e95935 Michael S. Tsirkin 2010-01-14  1984  

:::::: The code at line 1968 was first introduced by commit
:::::: 3a4d5c94e959359ece6d6b55045c3f046677f55c vhost_net: a kernel-level virtio server

:::::: TO: Michael S. Tsirkin <mst@redhat.com>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
